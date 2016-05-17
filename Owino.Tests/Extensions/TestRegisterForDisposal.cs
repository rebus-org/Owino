using System;
using System.Threading;
using Microsoft.Owin.Hosting;
using NUnit.Framework;
using Owin;
using Owino.Extensions;

namespace Owino.Tests.Extensions
{
    [TestFixture]
    public class TestRegisterForDisposal
    {
        [Test]
        public void CanRegisterThingsAndHaveThemDisposedWhenTheApplicationShutsDown()
        {
            var wasDisposed = false;

            var disposable = new CallToAction(() => wasDisposed = true);

            Action<IAppBuilder> configure = app =>
            {
                app.RegisterForDisposal(disposable);
            };

            using (WebApp.Start("http://localhost:6000", configure))
            {
                Thread.Sleep(300);
            }

            Assert.That(wasDisposed, Is.True);
        }

        class CallToAction : IDisposable
        {
            readonly Action _disposed;

            public CallToAction(Action disposed)
            {
                _disposed = disposed;
            }

            public void Dispose()
            {
                _disposed();
            }
        }
    }
}