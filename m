Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282FDA0163
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Aug 2019 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfH1MNU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Aug 2019 08:13:20 -0400
Received: from rs07.intra2net.com ([85.214.138.66]:37238 "EHLO
        rs07.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1MNT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:13:19 -0400
Received: from mail.m.i2n (unknown [172.17.128.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by rs07.intra2net.com (Postfix) with ESMTPS id CD3E815001B0;
        Wed, 28 Aug 2019 14:13:17 +0200 (CEST)
Received: from localhost (mail.m.i2n [127.0.0.1])
        by localhost (Postfix) with ESMTP id 8F48C438;
        Wed, 28 Aug 2019 14:13:17 +0200 (CEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.54.84,VDF=8.16.22.22)
X-Spam-Status: 
X-Spam-Level: 0
Received: from localhost (storm.m.i2n [172.16.1.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.m.i2n (Postfix) with ESMTPS id 1858F2C4;
        Wed, 28 Aug 2019 14:13:15 +0200 (CEST)
Date:   Wed, 28 Aug 2019 14:13:15 +0200
From:   Thomas Jarosch <thomas.jarosch@intra2net.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_conntrack_ftp: Fix debug output
Message-ID: <20190828121315.tbrrkl6567xwkmkx@intra2net.com>
References: <20190821141428.cjb535xrhpgry5zd@intra2net.com>
 <20190823123442.366wk6yoyct4b35m@salvia>
 <20190823125047.2yq5quu4mcwgh5b3@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823125047.2yq5quu4mcwgh5b3@intra2net.com>
User-Agent: NeoMutt/20180716
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

> One customer site is having FTP NAT problems after migrating from 3.14 to 4.19.
> The tcpdump traces look normal to me. Still IP addresses for passive FTP
> don't get rewritten with 4.19, it instantly works with 3.14.
> It works fine with 4.19 for me using test VMs.

quick follow up: Everything is working out of the box in the kernel. I finally 
had access to the machine and the FTP conntrack helper was not set up correctly.

Still it's good to have working debug code now.

Cheers,
Thomas
