Return-Path: <netfilter-devel+bounces-1744-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12B98A1B48
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Apr 2024 19:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086D81C22152
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Apr 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D2762E0;
	Thu, 11 Apr 2024 15:58:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83ED2BD06;
	Thu, 11 Apr 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851130; cv=none; b=M/IJjoFm6fIFbjzcUVuIoXpQSU61PcWckHd+O6GGo+UmNIYMLcRmZRND1xW6xg4Hh0gfgKqEPZ8iBJ7zO3QJGR/hLwv7u54mf0TmRSowk1L4ivfFcwmla2tly5iI6NLVuFEguP5tcRDLJ13uFkVekJrLEsC4YuKXNUTf8MLNziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851130; c=relaxed/simple;
	bh=r8HXxpQCT38wABk+zgJGuEMGjA8SqmC0HCefRTJ2Gwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NMjgqFH403S7i+PZk3cawt0R5kKqcQ7NV85toXiJdzhFNxaXPBDAbeduBDCWuNjHwOzQ+pTZxvlahxP3wcScL8Wg1U5wb2X5bgAztOVt8IQ+jay1QB+qdP/dqZaG3fuXXVdebn/WIikEu/DrLqnqPddiCKGkZPt9Z6rNWW4OIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VFkp257vxz1yn59;
	Thu, 11 Apr 2024 23:56:26 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id B5D411400C9;
	Thu, 11 Apr 2024 23:58:43 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 23:58:39 +0800
Message-ID: <9a8b71c6-f72c-7ec0-adee-5828dc41cf44@huawei-partners.com>
Date: Thu, 11 Apr 2024 18:58:34 +0300
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 03/10] selftests/landlock: Create 'create' test
Content-Language: ru
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
CC: <mic@digikod.net>, <willemdebruijn.kernel@gmail.com>,
	<gnoack3000@gmail.com>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<konstantin.meskhidze@huawei.com>
References: <20240408093927.1759381-1-ivanov.mikhail1@huawei-partners.com>
 <20240408093927.1759381-4-ivanov.mikhail1@huawei-partners.com>
 <ZhPsWKSRrqDiulrg@google.com>
From: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <ZhPsWKSRrqDiulrg@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 dggpemm500020.china.huawei.com (7.185.36.49)


4/8/2024 4:08 PM, Günther Noack wrote:
> Hello!
> 
> I am very happy to see this patch set, this is a very valuable feature, IMHO! :)
> 
> Regarding the subject of this patch:
> 
>    [RFC PATCH v1 03/10] selftests/landlock: Create 'create' test
>                                                     ^^^^^^
> 
> This was probably meant to say "socket"?

I wanted each such patch to have the name of the test that this patch
adds (without specifying the fixture, since this is not necessary
information, which only complicates the name). I think

     [RFC PATCH v1 03/10] selftests/landlock: Add 'create' test
                                              ~~~
renaming should be fine.

> 
> (In my mind, it is a good call to put the test in a separate file -
> the existing test files have grown too large already.)
> 
> 
> On Mon, Apr 08, 2024 at 05:39:20PM +0800, Ivanov Mikhail wrote:
>> Initiate socket_test.c selftests. Add protocol fixture for tests
>> with changeable domain/type values. Only most common variants of
>> protocols (like ipv4-tcp,ipv6-udp, unix) were added.
>> Add simple socket access right checking test.
>>
>> Signed-off-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
>> Reviewed-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>> ---
>>   .../testing/selftests/landlock/socket_test.c  | 197 ++++++++++++++++++
>>   1 file changed, 197 insertions(+)
>>   create mode 100644 tools/testing/selftests/landlock/socket_test.c
>>
>> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testing/selftests/landlock/socket_test.c
>> new file mode 100644
>> index 000000000..525f4f7df
>> --- /dev/null
>> +++ b/tools/testing/selftests/landlock/socket_test.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Landlock tests - Socket
>> + *
>> + * Copyright © 2024 Huawei Tech. Co., Ltd.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include <errno.h>
>> +#include <linux/landlock.h>
>> +#include <sched.h>
>> +#include <string.h>
>> +#include <sys/prctl.h>
>> +#include <sys/socket.h>
>> +
>> +#include "common.h"
>> +
>> +/* clang-format off */
>> +
>> +#define ACCESS_LAST LANDLOCK_ACCESS_SOCKET_CREATE
>> +
>> +#define ACCESS_ALL ( \
>> +	LANDLOCK_ACCESS_SOCKET_CREATE)
>> +
>> +/* clang-format on */
>> +
>> +struct protocol_variant {
>> +	int domain;
>> +	int type;
>> +};
>> +
>> +struct service_fixture {
>> +	struct protocol_variant protocol;
>> +};
>> +
>> +static void setup_namespace(struct __test_metadata *const _metadata)
>> +{
>> +	set_cap(_metadata, CAP_SYS_ADMIN);
>> +	ASSERT_EQ(0, unshare(CLONE_NEWNET));
>> +	clear_cap(_metadata, CAP_SYS_ADMIN);
>> +}
>> +
>> +static int socket_variant(const struct service_fixture *const srv)
>> +{
>> +	int ret;
>> +
>> +	ret = socket(srv->protocol.domain, srv->protocol.type | SOCK_CLOEXEC,
>> +			 0);
>> +	if (ret < 0)
>> +		return -errno;
>> +	return ret;
>> +}
> 
> This helper is mostly concerned with mapping the error code.
> 
> In the fs_test.c, we have dealt with such use cases with helpers like
> test_open_rel() and test_open().  These helpers attempt to open the file, take
> the same arguments as open(2), but instead of returning the opened fd, they only
> return 0 or errno.  Do you think this would be an option here?
> 
> Then you could write your tests as
> 
>    ASSERT_EQ(EACCES, test_socket(p->domain, p->type, 0));
> 
> and the test would (a) more obviously map to socket(2), and (b) keep relevant
> information like the expected error code at the top level of the test.
> 

I thought that `socket_variant()` would be suitable for future tests
where sockets can be used after creation (e.g. for sending FDs). But
until then, it's really better to replace it with what you suggested.

>> +
>> +FIXTURE(protocol)
>> +{
>> +	struct service_fixture srv0;
>> +};
>> +
>> +FIXTURE_VARIANT(protocol)
>> +{
>> +	const struct protocol_variant protocol;
>> +};
>> +
>> +FIXTURE_SETUP(protocol)
>> +{
>> +	disable_caps(_metadata);
>> +	self->srv0.protocol = variant->protocol;
>> +	setup_namespace(_metadata);
>> +};
>> +
>> +FIXTURE_TEARDOWN(protocol)
>> +{
>> +}
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(protocol, unspec) {
>> +	/* clang-format on */
>> +	.protocol = {
>> +		.domain = AF_UNSPEC,
>> +		.type = SOCK_STREAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(protocol, unix_stream) {
>> +	/* clang-format on */
>> +	.protocol = {
>> +		.domain = AF_UNIX,
>> +		.type = SOCK_STREAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(protocol, unix_dgram) {
>> +	/* clang-format on */
>> +	.protocol = {
>> +		.domain = AF_UNIX,
>> +		.type = SOCK_DGRAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(protocol, ipv4_tcp) {
>> +	/* clang-format on */
>> +	.protocol = {
>> +		.domain = AF_INET,
>> +		.type = SOCK_STREAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(protocol, ipv4_udp) {
>> +	/* clang-format on */
>> +	.protocol = {
>> +		.domain = AF_INET,
>> +		.type = SOCK_DGRAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(protocol, ipv6_tcp) {
>> +	/* clang-format on */
>> +	.protocol = {
>> +		.domain = AF_INET6,
>> +		.type = SOCK_STREAM,
>> +	},
>> +};
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(protocol, ipv6_udp) {
>> +	/* clang-format on */
>> +	.protocol = {
>> +		.domain = AF_INET6,
>> +		.type = SOCK_DGRAM,
>> +	},
>> +};
>> +
>> +static void test_socket_create(struct __test_metadata *const _metadata,
>> +				  const struct service_fixture *const srv,
>> +				  const bool deny_create)
>> +{
>> +	int fd;
>> +
>> +	fd = socket_variant(srv);
>> +	if (srv->protocol.domain == AF_UNSPEC) {
>> +		EXPECT_EQ(fd, -EAFNOSUPPORT);
>> +	} else if (deny_create) {
>> +		EXPECT_EQ(fd, -EACCES);
>> +	} else {
>> +		EXPECT_LE(0, fd)
>> +		{
>> +			TH_LOG("Failed to create socket: %s", strerror(errno));
>> +		}
>> +		EXPECT_EQ(0, close(fd));
>> +	}
>> +}
> 
> This is slightly too much logic in a test helper, for my taste,
> and the meaning of the true/false argument in the main test below
> is not very obvious.
> 
> Extending the idea from above, if test_socket() was simpler, would it
> be possible to turn these fixtures into something shorter like this:
> 
>    ASSERT_EQ(EAFNOSUPPORT, test_socket(AF_UNSPEC, SOCK_STREAM, 0));
>    ASSERT_EQ(EACCES, test_socket(AF_UNIX, SOCK_STREAM, 0));
>    ASSERT_EQ(EACCES, test_socket(AF_UNIX, SOCK_DGRAM, 0));
>    ASSERT_EQ(EACCES, test_socket(AF_INET, SOCK_STREAM, 0));
>    // etc.
> 
> Would that make the tests easier to write, to list out the table of
> expected values aspect like that, rather than in a fixture?
> 
> 

Initially, I conceived this function as an entity that allows to
separate the logic associated with the tested methods or usecases from
the logic of configuring the state of the Landlock ruleset in the
sandbox.

But at the moment, `test_socket_create()` is obviously a wrapper over
socket(2). So for now it's worth removing unnecessary logic.

But i don't think it's worth removing the fixtures here:

   * in my opinion, the design of the fixtures is quite convenient.
     It allows you to separate the definition of the object under test
     from the test case. E.g. test protocol.create checks the ability of
     Landlock to restrict the creation of a socket of a certain type,
     rather than the ability to restrict creation of UNIX, TCP, UDP...
     sockets

   * with adding more tests, it may be necessary to check all protocols
     in each of them

AF_UNSPEC should be removed from fixture variant to separate test,
though.

>> +
>> +TEST_F(protocol, create)
>> +{
>> +	const struct landlock_ruleset_attr ruleset_attr = {
>> +		.handled_access_socket = LANDLOCK_ACCESS_SOCKET_CREATE,
>> +	};
>> +	const struct landlock_socket_attr create_socket_attr = {
>> +		.allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>> +		.domain = self->srv0.protocol.domain,
>> +		.type = self->srv0.protocol.type,
>> +	};
>> +
>> +	int ruleset_fd;
>> +
>> +	/* Allowed create */
>> +	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>> +							sizeof(ruleset_attr), 0);
>> +	ASSERT_LE(0, ruleset_fd);
>> +
>> +	ASSERT_EQ(0,
>> +			landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
>> +					&create_socket_attr, 0));
> 
> The indentation looks wrong?  We run clang-format on Landlock files.
> 
>    clang-format -i security/landlock/*.[ch] \
>    	include/uapi/linux/landlock.h \
>    	tools/testing/selftests/landlock/*.[ch]
> 

Thanks! I'll fix indentation in the patch.

> —Günther

