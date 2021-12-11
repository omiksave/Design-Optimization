function drawContour(f, g)

    % Define the range of the contour plot
    x = -6:0.1:6;
    y = -6:0.1:6;
    
    % Evaluate objective values on the grid
    Zf = zeros(length(y),length(x));
    Zg1 = Zf; Zg2 = Zf;
    for i = 1:length(x)
        for j = 1:length(y)
            Zf(j,i) = feval(f,[x(i);y(j)]);
            gall = feval(g,[x(i);y(j)]);
            Zg1(j,i) = gall(1);
            Zg2(j,i) = gall(2);
        end
    end
    
    % Plot contour
    contourf(x, y, Zf, 100);
    contour(x,y,Zg1,[0;0],'Color', [1, 0, 0])
    contour(x,y,Zg2,[0;0],'Color', [1, 0, 1])
    Zg1(Zg1>0) = NaN;
    Zg2(Zg2>0) = NaN;
    contour(x,y,Zg1, 10,'Color', [1, 0, 0])
    contour(x,y,Zg2, 10,'Color', [1, 0, 1])
    shading flat;