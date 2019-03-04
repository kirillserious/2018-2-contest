function outStruct = plotFT(hFigure, fHandle, fFTHandle, step, inpLimVec, outLimVec)
    % ����� ���������
    a = inpLimVec(1);
    b = inpLimVec(2);
    delta0 = b - a;
    n = fix(delta0/step);    % ���� n ��� ����� ����� �� �������
    deltaT = delta0 / n;     % ������������� ��� �������������
    
    % ���������� � ������
    SPlotInfo = get(hFigure, 'UserData');
    
    % � ������ �� ��������� ��������� outLimVec, ������� ��� ���������
    if nargin == 5
        outLimVec = [-2*pi/deltaT, 2*pi/deltaT];
    end
    
    % ���� ���������� � ������ ��� - ������������ ������
    if numel(SPlotInfo) == 0
        clf(hFigure);
        reGObject = subplot(2, 1, 1);
        imGObject = subplot(2, 1, 2);
        reOutLimVec = outLimVec;
        imOutLimVec = outLimVec;
    % ���������� � ������ ���� - ������ ���
    else
        % outLimVec �� ����� - ������ �� ����
        if nargin == 5
            outLimVec   = SPlotInfo.reOutLimVec;
            reOutLimVec = SPlotInfo.reOutLimVec;
            imOutLimVec = SPlotInfo.imOutLimVec;
        else
            reOutLimVec = outLimVec;
            imOutLimVec = outLimVec;
        end
        reGObject = SPlotInfo.reGObject;
        imGObject = SPlotInfo.imGObject;
        
        cla(reGObject);
        cla(imGObject);
    end
    
    % ������� ���������� �������������� �����
    tVec = a : deltaT : b;
     
    lambdaVec = 0 : 2*pi/delta0 : 2*pi/deltaT;               % c���������� ������ ��� fft
    lambdaVec = lambdaVec - pi/deltaT;                       % �������� \lambda �������  
    
    if mod(numel(lambdaVec), 2) == 0        % ����� �� ����� circshift, �� �������� � ����
        lambdaVec = lambdaVec - pi/delta0;               
    end                  
    
    %k = find(abs(tVec) < deltaT-eps, 2, 'first');
    %fftVec = deltaT .* fftshift(fft(circshift(fHandle(tVec), -k)));
    fftVec = deltaT * exp(-1i*a*lambdaVec) .* fftshift(fft(fHandle(tVec)));
    
    %fftVec(abs(lambdaVec) < 10^-10)

    plot(reGObject, lambdaVec, real(fftVec));
    plot(imGObject, lambdaVec, imag(fftVec));


    
    if numel(fFTHandle) ~= 0
        reGOptions = reGObject.NextPlot;
        imGOptions = imGObject.NextPlot;
        reGObject.NextPlot = 'add';
        imGObject.NextPlot = 'add';
        
        plot(reGObject, lambdaVec, real(fFTHandle(lambdaVec)));
        plot(reGObject, lambdaVec, abs(real(fFTHandle(lambdaVec)) - real(fftVec)));
        plot(imGObject, lambdaVec, imag(fFTHandle(lambdaVec)));
        plot(imGObject, lambdaVec, abs(imag(fFTHandle(lambdaVec)) - imag(fftVec)));
        
        
        legend(reGObject, {'������� �������������� �����','������', '�������������� �����'});
        legend(imGObject, {'������� �������������� �����','������', '�������������� �����'});
        
        reGObject.NextPlot = reGOptions;
        imGObject.NextPlot = imGOptions;   
    end
    
    title(reGObject, '������������ ����� �������������� �����');
    title(imGObject, '������ ����� �������������� �����');
    xlim(reGObject,reOutLimVec);
    xlim(imGObject,imOutLimVec);
    
    xlabel(reGObject, '\lambda');
    ylabel(reGObject, '\Ree F');
    xlabel(imGObject, '\lambda');
    ylabel(imGObject, '\Imm F');
    
    grid(reGObject,'on');
    grid(imGObject,'on');
    SPlotInfo = struct('reGObject', reGObject,  'imGObject', imGObject,...
        'reOutLimVec', reOutLimVec, 'imOutLimVec', imOutLimVec);
    hFigure.UserData = SPlotInfo;
    
    
    
    outStruct = struct('nPoints', n, 'step', deltaT, 'inpLimVec', inpLimVec, 'outLimVec', outLimVec);
end