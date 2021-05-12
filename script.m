%lee el video
filename = 'caras 1.avi';
video = VideoReader(filename);

primeraVez = true;

while hasFrame(video)
    % lee frame de la imagen, lo pasa a double y luego a gris
   
    ptThresh = 0.1;
    
    if primeraVez
        input = rgb2gray(im2double(readFrame(video)));
        actF = detectFASTFeatures(input,'MinContrast',ptThresh);
        primeraVez = false;
        
    else
        antInput = input;
        input = rgb2gray(im2double(readFrame(video)));
        antF = actF;
        actF = detectFASTFeatures(input,'MinContrast',ptThresh);
        %Extraer el descriptor Fast Retina Keypoint(FREAK)
        [featuresAnt,antF] = extractFeatures(antInput, antF);
        [featuresAct,actF] = extractFeatures(input, actF);

        parejas = matchFeatures(featuresAnt,featuresAct);
        antF = antF(indexPairs(:,1),:);
        actF = actF(indexPairs(:,2),:);
        
      
    end
    
    
    _%hVideoOut([input(:,:,1) input]);
end

