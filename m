Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51ACB8C9A
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Sep 2019 10:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437800AbfITIW4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Sep 2019 04:22:56 -0400
Received: from correo.us.es ([193.147.175.20]:44792 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437798AbfITIWz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:22:55 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 85F8E18CE74
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 10:22:51 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 76143DA8E8
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 10:22:51 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6B99BDA72F; Fri, 20 Sep 2019 10:22:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 79F22B7FF2;
        Fri, 20 Sep 2019 10:22:49 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Sep 2019 10:22:49 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [5.182.56.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1C3D84265A5A;
        Fri, 20 Sep 2019 10:22:49 +0200 (CEST)
Date:   Fri, 20 Sep 2019 10:22:47 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: allow lookups in dynamic sets
Message-ID: <20190920082247.cryrh4awey753ptn@salvia>
References: <20190919145644.32119-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919145644.32119-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:56:44PM +0200, Florian Westphal wrote:
> This un-breaks lookups in sets that have the 'dynamic' flag set.

Applied, thanks.
