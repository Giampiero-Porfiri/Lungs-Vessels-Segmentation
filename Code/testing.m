%% Result testing
resultFile = 'C:\Users\giamp\Desktop\Lungs Segmentation\ExampleScans\Annotations\VESSEL12_23_Annotations.csv';
inputs = readcell(resultFile);
resultArray = [];
for i = 1 : 4 : size(inputs)
    coordinates = strcat(inputs(i, 1), inputs(i, 2), inputs(i, 3));
    coordinateX = (coordinates{1}(1));
    coordinateY = (coordinates{1}(2));
    coordinateZ = (coordinates{1}(3));
    if Data[coordinateX; coordinateY; coordinateZ] == 0
        resultArray(i) = 0;
    else
        resultArray(i) = 1;
    end
end
xlswrite(resultFile, resultArray', 1, 'C');