function printField(field,label,format)
% print_field(field,label) prints a field with an Arakawa-C notation
% field: field to be printed
% label: string with the field description
% format: fprintf format

    N = size(field,1)-2; %mesh size
    fprintf('field %s \n',label); % prints a string containing the label
    for j = N+2:-1:1 % closed loop from the bottom row upwards
        fprintf('j=%2d ',j); % prints the vertical position
        for i = 1:N+2 % closed loop from left to right
            fprintf(format,field(i,j));
        end
        fprintf('\n'); % line change
    end
end