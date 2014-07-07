function [] = plotedge( xi,yi,zi )

m=max(size(xi));
for i=1:m-1
    line([xi(i) xi(i+1)], [yi(i), yi(i+1)], [zi(i), zi(i+1)]);
end

