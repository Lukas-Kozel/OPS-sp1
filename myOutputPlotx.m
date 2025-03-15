function stop = myOutputPlotx(x,optimValues,state,axes_h)
% Function called by the optimization solver at each iteration

% We do not want to stop iteration
stop = false;

% If iteration is ion progess plot corrent iteration
switch state
    case 'iter'
        if optimValues.iteration == 0
            % if it is first iteration create new object of type
            % 'lineseries'
            lineseries_h = plot(axes_h,x(1),x(2),'.-');
            set(lineseries_h,'Tag','iterationplot')
        else
            % At next iterations find the object using tag and update its
            % properties such the new iteration is plotted
            lineseries_h = findobj(get(axes_h,'Children'),'Tag','iterationplot');
            X = get(lineseries_h,'Xdata');
            Y = get(lineseries_h,'Ydata');
            X = [X x(1)];
            Y = [Y x(2)];
            set(lineseries_h,'Xdata',X);
            set(lineseries_h,'Ydata',Y);
        end
end