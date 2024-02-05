# Cloudinary iOS Sample application

## Introduction
This is a very simple application that integrates the [Cloudinary iOS SDK](https://github.com/cloudinary/cloudinary_ios).
The application has the following samples:
1. Delivery
  1. Optimization
  2. Transform
  3. Use cases
2. Upload
   1. Upload
   2. Upload large
   3. Fetch upload
3. UI
   1. Upload Widget
   2. Image Widget
4. Video
   3. Video Widget   
   4. Video Feed

## Configuration
Once you clone this repository there are two required steps to build the sample app:
1. Configure your Cloudinary cloud name for the app:
    * Once you open the upload controller you'll be asked to enter your cloud name, you can find your cloud name [here](https://cloudinary.com/documentation/how_to_integrate_cloudinary#create_and_explore_your_account)
2. Create an upload preset named 'sample_app_preset' in your cloudinary account console:
    *  Login to your [Cloudinary console](https://cloudinary.com/console), go to settings>upload, scroll down
      to Upload Presets and click `Add upload preset`. Alternatively, head directly to the [new preset page](https://cloudinary.com/console/lui/upload_presets/new).
    * Type in `android_sample` as the name and save, leaving all the fields with their default values.
    
