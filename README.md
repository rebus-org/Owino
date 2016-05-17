# Owino

Useful things for OWIN.

### 1. Proper disposal of things when the web application shuts down

OWIN does not have any intuitive ways of disposing things when the application shuts down.
It IS possible however, by attaching oneself to the `CancellationToken` residing under the
`host.OnAppDisposing` key in the app's properties.

Here's how you do it with Owino e.g. if you are using Castle Windsor for something:

    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            var container = new WindsorContainer().Install(FromAssembly.This());

            // register some middlewarez, and then:

            app.RegisterForDisposal(container)
            // oh, good... ALWAYS dispose your IoC container after use!
        }
    }

(in case you didn't notice: `RegisterForDisposal` is an extension method on
`IAppBuilder`)

