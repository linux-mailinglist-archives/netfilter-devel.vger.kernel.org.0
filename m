Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD53A9AFED
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Aug 2019 14:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfHWMuv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Aug 2019 08:50:51 -0400
Received: from rp02.intra2net.com ([62.75.181.28]:56434 "EHLO
        rp02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388720AbfHWMuv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:50:51 -0400
Received: from mail.m.i2n (unknown [172.17.128.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by rp02.intra2net.com (Postfix) with ESMTPS id AA193100168;
        Fri, 23 Aug 2019 14:50:49 +0200 (CEST)
Received: from localhost (mail.m.i2n [127.0.0.1])
        by localhost (Postfix) with ESMTP id 85DEE827;
        Fri, 23 Aug 2019 14:50:49 +0200 (CEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.54.80,VDF=8.16.21.178)
X-Spam-Status: 
X-Spam-Level: 0
Received: from localhost (storm.m.i2n [172.16.1.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.m.i2n (Postfix) with ESMTPS id 6B2CF39A;
        Fri, 23 Aug 2019 14:50:47 +0200 (CEST)
Date:   Fri, 23 Aug 2019 14:50:47 +0200
From:   Thomas Jarosch <thomas.jarosch@intra2net.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_conntrack_ftp: Fix debug output
Message-ID: <20190823125047.2yq5quu4mcwgh5b3@intra2net.com>
References: <20190821141428.cjb535xrhpgry5zd@intra2net.com>
 <20190823123442.366wk6yoyct4b35m@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823123442.366wk6yoyct4b35m@salvia>
User-Agent: NeoMutt/20180716
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

You wrote on Fri, Aug 23, 2019 at 02:34:42PM +0200:
> On Wed, Aug 21, 2019 at 04:14:28PM +0200, Thomas Jarosch wrote:
> > The find_pattern() debug output was printing the 'skip' character.
> > This can be a NULL-byte and messes up further pr_debug() output.
> > 
> > Output without the fix:
> > kernel: nf_conntrack_ftp: Pattern matches!
> > kernel: nf_conntrack_ftp: Skipped up to `<7>nf_conntrack_ftp: find_pattern `PORT': dlen = 8
> > kernel: nf_conntrack_ftp: find_pattern `EPRT': dlen = 8
> > 
> > Output with the fix:
> > kernel: nf_conntrack_ftp: Pattern matches!
> > kernel: nf_conntrack_ftp: Skipped up to 0x0 delimiter!
> > kernel: nf_conntrack_ftp: Match succeeded!
> > kernel: nf_conntrack_ftp: conntrack_ftp: match `172,17,0,100,200,207' (20 bytes at 4150681645)
> > kernel: nf_conntrack_ftp: find_pattern `PORT': dlen = 8
> 
> Do you use this debugging? I haven't use it for years.

unfortunately, yes :)

One customer site is having FTP NAT problems after migrating from 3.14 to 4.19.
The tcpdump traces look normal to me. Still IP addresses for passive FTP
don't get rewritten with 4.19, it instantly works with 3.14.
It works fine with 4.19 for me using test VMs.

It sounds a bit like this:
https://bugzilla.netfilter.org/show_bug.cgi?id=1164

Florian's slides about the NAT helper were helpful in general:
https://strlen.de/talks/nfdebug.pdf

-> NAT helpers are best effort, but like I said, it should
work given the packets dumps I have seen so far.

I hope to install a kernel with this debug output at the customer site soon.
As it's the central gateway of a township, I can't reboot the machine
easily and they have quite strict working hours. I'll keep nagging them ;)

Cheers,
Thomas
