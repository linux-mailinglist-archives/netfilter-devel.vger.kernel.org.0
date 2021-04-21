Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5C366633
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Apr 2021 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhDUHWH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Apr 2021 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbhDUHWC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:22:02 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B57C06174A
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Apr 2021 00:21:27 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 565F65876D2BB; Wed, 21 Apr 2021 09:21:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 5118060C62EBE;
        Wed, 21 Apr 2021 09:21:26 +0200 (CEST)
Date:   Wed, 21 Apr 2021 09:21:26 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Duncan Roe <duncan.roe2@gmail.com>
cc:     netfilter-devel@vger.kernel.org, duncan_roe@optusnet.com.au
Subject: Re: [PATCH libnetfilter_queue 1/1] build: doc: `make distcheck`
 passes with doxygen enabled
In-Reply-To: <20210421021745.GA9334@smallstar.local.net>
Message-ID: <8044rs51-qqq5-223o-q410-q46nsn566pqo@vanv.qr>
References: <20210420042358.2829-1-duncan_roe@optusnet.com.au> <20210420042358.2829-2-duncan_roe@optusnet.com.au> <3219so45-rsq1-8093-77pr-39oo80or6q@vanv.qr> <20210421021745.GA9334@smallstar.local.net>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2021-04-21 04:17, Duncan Roe wrote:
>> >+if test -z "$DOXYGEN"; then
>>
>> If you use AS_IF above, you could also make use of it here :)
>
>Happy to do that, but could you spell out the actual line please? My grasp of m4
>is tenuous at best - I only copy stuff that I see working elsewhere.

AS_IF([test -z "$DOXYGEN], [what if true], [what if false])


>
>In this case I copied Florian Westphal's code from 3622e606.
>>
>> >+# move it out of the way and symlink the real one while we run doxygen.
>> >+	cd ..; [ $$(ls src | wc -l) -gt 8 ] ||\
>>
>> This looks like it could break anytime (say, when it happens to get to 9
>> files). Can't it test for a specific filename or set of names?
>
>OK I can test for existence of Makefile.in.
>>
>> >+       function main { set -e; cd man/man3; rm -f _*;\
>>
>> The syntax for POSIX sh-compatible functions should be
>>
>> 	main() { ...
>
>Rats! I had it that way, but the old fixmanpages.sh had 'function' so I changed
>it to minimise the diff. Will change back to POSIX way in v2.

The old fixmanpages.sh had #!/bin/bash, which forced bash, but such guarantee
does not exist for the Makefile at this point (and the change to POSIX sh
is nonintrusive anyway).

>> >+function setgroup { mv $$1.3 $$2.3; BASE=$$2; };\
>> >+function add2group { for i in $$@; do ln -sf $$BASE.3 $$i.3; done; };\
>>
>> Should be quoted, i.e. "$$@". Might as well do it for the other vars.
>
>"Should be"? We're dealing with man page names. If unquoted $$@ fails, we've got
>other problems.

Yeah, make does not lend itself well to filenames with spaces I guess.
