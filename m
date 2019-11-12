Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA91F9C6A
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Nov 2019 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLVkE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Nov 2019 16:40:04 -0500
Received: from correo.us.es ([193.147.175.20]:39054 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLVkE (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:40:04 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3A883A1A34A
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Nov 2019 22:40:00 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2C56ADA8E8
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Nov 2019 22:40:00 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 21EBBDA801; Tue, 12 Nov 2019 22:40:00 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 44183DA4CA;
        Tue, 12 Nov 2019 22:39:58 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 12 Nov 2019 22:39:58 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1F6724251480;
        Tue, 12 Nov 2019 22:39:58 +0100 (CET)
Date:   Tue, 12 Nov 2019 22:39:59 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] meta: Rewrite hour_type_print()
Message-ID: <20191112213959.bv7senr6tdrpckky@salvia>
References: <20191112185931.8455-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112185931.8455-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 12, 2019 at 07:59:31PM +0100, Phil Sutter wrote:
> There was no point in this recursively called __hour_type_print_r() at
> all, it takes only four lines of code to split the number of seconds
> into hours, minutes and seconds.
> 
> While being at it, inverse the conditional to reduce indenting for the
> largest part of the function's body. Also introduce SECONDS_PER_DAY
> macro to avoid magic numbers.
> 
> Fixes: f8f32deda31df ("meta: Introduce new conditions 'time', 'day' and 'hour'")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
