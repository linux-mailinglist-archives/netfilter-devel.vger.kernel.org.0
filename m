Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7ED4D2B80
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Mar 2022 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiCIJNG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Mar 2022 04:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCIJNG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:13:06 -0500
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 01:12:06 PST
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364216BF9F
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Mar 2022 01:12:06 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 464F7CC0108;
        Wed,  9 Mar 2022 10:02:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Wed,  9 Mar 2022 10:02:53 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id F1185CC0100;
        Wed,  9 Mar 2022 10:02:52 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id EBACB340D76; Wed,  9 Mar 2022 10:02:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id E9B27340D74;
        Wed,  9 Mar 2022 10:02:52 +0100 (CET)
Date:   Wed, 9 Mar 2022 10:02:52 +0100 (CET)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     Ian Pilcher <arequipeno@gmail.com>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: Looking for info on ipset set type revisions
In-Reply-To: <32c1b5d3-59f9-8bf2-ee22-f4b6708d57be@gmail.com>
Message-ID: <ffa9a4f-d09b-302b-3df6-89d33d88c8f@netfilter.org>
References: <32c1b5d3-59f9-8bf2-ee22-f4b6708d57be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Ian,

On Tue, 8 Mar 2022, Ian Pilcher wrote:

> I am working on a C program that uses libmnl to do some basic ipset 
> manipulation - namely create a set of type hash:ip,port and then add 
> entries.
> 
> The best technique I've found to figure out the exact messages required 
> is to use strace with the ipset command.  strace does a pretty good job 
> of decoding the netlink messages, and I can generally figure out the 
> significance and meaning of other constants by looking at the various 
> header files.
> 
> The one thing that I haven't yet been able to figure out is set type
> revisions.  When I use ipset to create a hash:ip,port set, I see that
> it is passing 6 as the IPSET_ATTR_REVISION.  I can also that 6 is the
> latest revision in lib/ipset_hash_ipportip.c, which is fine when using
> the ipset command or calling libipset.
> 
> What about programs that don't use libipset?  How can an application
> determine the latest/correct revision of a particular set type?  

You can query the kernel about the highest revision number it supports for 
a given set type by sending an IPSET_CMD_TYPE message. There's a tiny 
documentation about the messages and their format in lib/PROTOCOL. 
However, not relying on libipset then you have to know which features are 
available in the given revision.

> I haven't been able to find anything in any of the header files that 
> seems relevant, nor do I see any way for an application to discover this 
> information at runtime.
> 
> Should I just hardcode 6?

You can hardcode the highest revision number for a given set type from 
libipset. I don't plan new revisions to introduce and even if that would 
happen, the only downside of hardcoding the number is that you won't be 
able to use new features introduced in higher revisions.

The kernel part always provides backward compatibility.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
