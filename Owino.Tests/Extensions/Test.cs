using System;
using NUnit.Framework;

namespace Owino.Tests.Extensions
{
    [TestFixture]
    public class Test
    {
        [Test]
        public void PrintAppDomainPath()
        {
            Console.WriteLine($"basedi: {AppDomain.CurrentDomain.BaseDirectory}");
        }
    }
}