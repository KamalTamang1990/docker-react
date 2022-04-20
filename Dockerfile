# Build Phase
FROM node:alpine as builder 

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run Phase
FROM nginx
# copy over the result of 'npm run build' from Build phase to Nginx /usr/share/nginx/html
# only the build folder is copied while other source code aren't coz we care only about the build that has all the configuration while it got built on the Build phase
COPY --from=builder /app/build /usr/share/nginx/html


