Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F21F9B6E
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Nov 2019 22:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLVDG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Nov 2019 16:03:06 -0500
Received: from correo.us.es ([193.147.175.20]:53208 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfKLVDG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:03:06 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1990D11EB3A
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Nov 2019 22:03:02 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0B705DA4D0
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Nov 2019 22:03:02 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 010B2DA8E8; Tue, 12 Nov 2019 22:03:02 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 200CFDA7B6;
        Tue, 12 Nov 2019 22:03:00 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 12 Nov 2019 22:03:00 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id EE1064251481;
        Tue, 12 Nov 2019 22:02:59 +0100 (CET)
Date:   Tue, 12 Nov 2019 22:03:01 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/1] ipset patches for nf-next
Message-ID: <20191112210301.dtrjpnyvpkgh4uwb@salvia>
References: <20191101163626.10649-1-kadlec@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101163626.10649-1-kadlec@blackhole.kfki.hu>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 01, 2019 at 05:36:25PM +0100, Jozsef Kadlecsik wrote:
> Hi Pablo,
> 
> Please consider applying the next patch for the nf-next tree:
> 
> - Add wildcard support to hash:net,iface which makes possible to
>   match interface prefixes besides complete interfaces names, from
>   Kristian Evensen.

Pulled, thanks for your patience Jozsef.
