clear;
clc;
import_data %creates data variable

count = zeros(1,3);
CA = cell (3,4);
for i = 1:size(data,1)
    for j = 1:3
        if data(i,j) == 1
            count(1,j) = count(1,j)+1;                
            CA{j,1} = [CA{j,1} data(i,4)];
            CA{j,2} = [CA{j,2} data(i,5)];
            CA{j,3} = [CA{j,3} data(i,6)];
            CA{j,4} = [CA{j,4} data(i,7)];
        end        
    end
end

CAmean = zeros(3,4);
CAstd = zeros(3,4);

for i = 1:size(CA,1)
    for j = 1:size(CA,2)
        CAmean(i,j) = mean(CA{i,j});
        CAstd(i,j) = std(CA{i,j});
    end
end


test = data;
test(:,1:3) = [];
matches = 0;

for k = 1:size(test,1)

    exits = count/size(data,1);
    for i = 1:3
        for j = 1:size(test(k,:),2) 
            exits(1,i) = exits(1,i)*(1/sqrt(2*pi*CAstd(i,j)))*exp(-(((test(k,j)-CAmean(i,j)).^2/2*CAstd(i,j)^2)));
        end
    end

    max = 1;
    for i = 2:size(exits,2)
        if(exits(1,i) > exits(1,max))
            max = i;
        end
    end

    %exits = zeros(1,3);
    %exits(1,max) = 1;
    if(data(k,max)) == 1 
        matches = matches+1;
    end
end