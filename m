Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65FE10D22F
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Nov 2019 09:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfK2IBp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Nov 2019 03:01:45 -0500
Received: from correo.us.es ([193.147.175.20]:33482 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfK2IBp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:01:45 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A38C811EBA6
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Nov 2019 09:01:41 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 95782DA713
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Nov 2019 09:01:41 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8AC65DA711; Fri, 29 Nov 2019 09:01:41 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8F142DA709;
        Fri, 29 Nov 2019 09:01:39 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 29 Nov 2019 09:01:39 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 603624265A5A;
        Fri, 29 Nov 2019 09:01:39 +0100 (CET)
Date:   Fri, 29 Nov 2019 09:01:40 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: tell compile to not inline
 nf_ct_resolve_clash
Message-ID: <20191129080140.tqqzgb6xbxvgioiw@salvia>
References: <20191128122548.20080-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128122548.20080-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 28, 2019 at 01:25:48PM +0100, Florian Westphal wrote:
> At this time compiler inlines it, but this code will not be executed
> under normal conditions.
> 
> Also, no inlining allows to use "nf_ct_resolve_clash%return" perf probe.

Applied, thanks Florian.
