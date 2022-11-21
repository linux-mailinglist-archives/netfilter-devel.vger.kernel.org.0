Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59308632C8B
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Nov 2022 20:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKUTCQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Nov 2022 14:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKUTCH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:02:07 -0500
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7A1CFE80
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Nov 2022 11:02:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 104FECC010C;
        Mon, 21 Nov 2022 20:01:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 21 Nov 2022 20:01:53 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 17B5ACC00FF;
        Mon, 21 Nov 2022 20:01:52 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id F28C8343157; Mon, 21 Nov 2022 20:01:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id F0D04343156;
        Mon, 21 Nov 2022 20:01:52 +0100 (CET)
Date:   Mon, 21 Nov 2022 20:01:52 +0100 (CET)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     Vishwanath Pai <vpai@akamai.com>
cc:     pablo@netfilter.org, fw@strlen.de, johunt@akamai.com,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] netfilter: ipset: Add support for new bitmask
 parameter (userspace)
In-Reply-To: <20221110213131.2083331-1-vpai@akamai.com>
Message-ID: <bca72b11-69e6-a795-5fe9-8c359df5cd5@netfilter.org>
References: <20221110213131.2083331-1-vpai@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Vishwanath,

On Thu, 10 Nov 2022, Vishwanath Pai wrote:

> Add a new parameter to complement the existing 'netmask' option. The 
> main difference between netmask and bitmask is that bitmask takes any 
> arbitrary ip address as input, it does not have to be a valid netmask.
> 
> The name of the new parameter is 'bitmask'. This lets us mask out
> arbitrary bits in the ip address, for example:
> ipset create set1 hash:ip bitmask 255.128.255.0
> ipset create set2 hash:ip,port family inet6 bitmask ffff::ff80
> 
> This patchset contains userspace patches, I will submit the kernel patch
> separately.
> 
> Changes in v3:
> * Add netmask option to hash:net,net
> * Update man page for hash:net,net
> * Add netmask tests to hash:net,net
> * Add check in userspace to make sure netmask and bitmask options are mutually exclusive
> * Add a test to make sure netmask/bitmask are mutually exclusive
> 
> Changes in v2:
>     * Removed the changes to nf_inet_addr.h and nfproto.h, this will break on older kernels
>     * Remove bitmask option from net,net since it is redundant, update the manpage
>     * Add tests for the new bitmask param (similar to netmask tests)
> 
> Vishwanath Pai (6):
>   netfilter: ipset: Add support for new bitmask parameter
>   netfilter: ipset: Add bitmask support to hash:ip
>   netfilter: ipset: Add bitmask support to hash:ipport
>   netfilter: ipset: Add bitmask support to hash:netnet
>   netfilter: ipset: Update the man page to include netmask/bitmask
>     options
>   netfilter: ipset: add tests for the new bitmask feature

The patches including the kernel side one have been applied to the ipset 
git repo and I'm about to submit the kernel patch for kernel inclusion. 
Thanks!

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
