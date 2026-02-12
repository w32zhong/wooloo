const fastify = require('fastify')({ logger: true, disableRequestLogging: true });

//{
//  event_type: 'create',
//  key: '/buckets/vps/by-user_foo',
//  message: {
//  new_entry: {
//      name: 'README.md',
//      ...
//    },
//    new_parent_path: '/buckets/vps',
//    ...
//  }
//}

fastify.post('/webhook', async (request, reply) => {
  const { body } = request;
  msg = body.message
  if (body.event_type === 'create' && msg.new_parent_path === '/buckets/vps') {
    const name = msg.new_entry.name
    console.log(name)
  }
  return {status: 'received'};
});

const start = async () => {
  try {
    await fastify.listen({ port: 5000, host: '0.0.0.0' });
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};
start();
