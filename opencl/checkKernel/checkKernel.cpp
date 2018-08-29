/*  OpenCL Error Checker
 *  Copyright (C) <2018>  <Juan Fumero>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Check if an OpenCL kernel compiles and if not, returns the list
 * of errors and warnings.
 * Author: Juan Fumero
 * Date  : 14/12/2017
 *
 */
#include <iostream>
#include <string>
#include <sys/time.h>
#include <chrono>
using namespace std;

#define CL_USE_DEPRECATED_OPENCL_2_0_APIS

#ifdef __APPLE__
	#include <OpenCL/cl.h>
#else
	#include <CL/cl.h>
#endif

const int PLATFORM_ID = 0;

string platformName;
cl_uint numPlatforms;
cl_platform_id *platforms;
cl_device_id *devices;
cl_context context;
cl_command_queue commandQueue;
cl_kernel kernel;
cl_program program;
char *source;

char *readsource(const char *sourceFilename) {

    FILE *fp;
    int err;
    int size;
    char *source;
	
    fp = fopen(sourceFilename, "rb");
 
    if(fp == NULL) {
       printf("Could not open kernel file: %s\n", sourceFilename);
       exit(-1);
    }
 
    err = fseek(fp, 0, SEEK_END);
 
    if(err != 0) {
       printf("Error seeking to end of file\n");
       exit(-1);
 
    }
    size = ftell(fp);
 
    if(size < 0) {
       printf("Error getting file position\n");
       exit(-1);
    }
 
    err = fseek(fp, 0, SEEK_SET);
    if(err != 0) {
       printf("Error seeking to start of file\n");
       exit(-1);
 
    }
 
    source = (char*)malloc(size+1);
 
    if(source == NULL) {
       printf("Error allocating %d bytes for the program source\n", size+1);
       exit(-1);
    }
 
    err = fread(source, 1, size, fp);
    if(err != size) {
       printf("only read %d bytes\n", err);
       exit(0);
    }
 
    source[size] = '\0';
    return source;
}


int openclInitialization(const char* fileName, const char* kernelName) {

	cl_int status;	
	cl_uint numPlatforms = 0;

	status = clGetPlatformIDs(0, NULL, &numPlatforms);

	if (numPlatforms == 0) {
		cout << "No platform detected" << endl;
		return -1;
	}

	platforms = (cl_platform_id*) malloc(numPlatforms*sizeof(cl_platform_id));
	if (platforms == NULL) {
		cout << "malloc platform_id failed" << endl;
		return -1;
	}
	
	status = clGetPlatformIDs(numPlatforms, platforms, NULL);
	if (status != CL_SUCCESS) {
		cout << "clGetPlatformIDs failed" << endl;
		return -1;
	}	

	cout << numPlatforms <<  " has been detected" << endl;
	for (int i = 0; i < numPlatforms; i++) {
		char buf[10000];
		cout << "Platform: " << i << endl;
		status = clGetPlatformInfo(platforms[i], CL_PLATFORM_VENDOR, sizeof(buf), buf, NULL);
		if (i == PLATFORM_ID) {
			platformName += buf;
		}
		cout << "\tVendor: " << buf << endl;
		status = clGetPlatformInfo(platforms[i], CL_PLATFORM_NAME, sizeof(buf), buf, NULL);
	}

	cl_uint numDevices = 0;

	cl_platform_id platform = platforms[PLATFORM_ID];
	std::cout << "Using platform: " << PLATFORM_ID << " --> " << platformName << std::endl;

	status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 0, NULL, &numDevices);
	
	if (status != CL_SUCCESS) {
		cout << "[WARNING] Using CPU, no GPU available" << endl;
		status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_CPU, 0, NULL, &numDevices);
		devices = (cl_device_id*) malloc(numDevices*sizeof(cl_device_id));
		status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_CPU, numDevices, devices, NULL);
	} else {
		devices = (cl_device_id*) malloc(numDevices*sizeof(cl_device_id));
		status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, numDevices, devices, NULL);
	}
	
	context = clCreateContext(NULL, numDevices, devices, NULL, NULL, &status);
	
	commandQueue = clCreateCommandQueue(context, devices[0], CL_QUEUE_PROFILING_ENABLE, &status);	
	if (status != CL_SUCCESS || commandQueue == NULL) {
		cout << "Error in create command" << endl;
		return -1;
	}

	const char *sourceFile = fileName;
	source = readsource(sourceFile);
	program = clCreateProgramWithSource(context, 1, (const char**)&source, NULL, &status);

	cout << "\n##################################################" << endl;
	cout << "Compiling the OpenCL program: " << fileName << endl;
	cout << "##################################################" << endl;
	
	if (status != CL_SUCCESS) {
		cout << "Error compiling the program" << endl;
		return -1;
	}

	cl_int ret;
	cl_int buildErr = clBuildProgram(program, numDevices, devices, NULL, NULL, NULL);
	if (buildErr != CL_SUCCESS) {
		cout << "Error compiling the kernel" << endl;
	}

	// Print log 
	cl_device_id device_id = devices[0];
	size_t len;
    char buffer[204800];
    cl_build_status bldstatus;
    ret = clGetProgramBuildInfo(program, device_id, CL_PROGRAM_BUILD_LOG, sizeof(buffer), buffer, &len); 
	printf("\n\n**Build Log:** \n%s \n", buffer);
	cout << endl;

	if (buildErr != CL_SUCCESS) {
		cout << "Abort" << endl;
		return 1;
	}	

	kernel = clCreateKernel(program, kernelName, &status);

	if (status != CL_SUCCESS) {
		cout << "Error creating the kernel object" << endl;
	}
}


void freeMemory() {
	clReleaseKernel(kernel);
	clReleaseProgram(program);
	clReleaseCommandQueue(commandQueue);
	clReleaseContext(context);
	free(source);
	free(platforms);
	free(devices);
}

int main(int argc, char **argv) {

	cout << "OpenCL Kernel Checker " << endl;

	if (argc < 3) {
		cout << "Provide <kernel.cl> <mainKernelName> " << endl;
	} else {
		int status = openclInitialization(argv[1], argv[2]);
		if (status == -1) {
			return -1;
		}
		freeMemory();
	}

	return 0;	
}

