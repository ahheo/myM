function hf=init_f(w_,h_,varargin)
hf=figure(varargin{:});

hf.Units='inches';
hf.Position=[0, 0, w_, h_];
hf.Color='none';
hf.PaperUnits = 'inches';
hf.PaperSize = [w_,h_];
hf.PaperPosition = [0, 0, w_, h_];
hf.PaperPositionMode = 'Manual';
end