Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2E9EF43
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Aug 2019 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfH0Ppx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Aug 2019 11:45:53 -0400
Received: from correo.us.es ([193.147.175.20]:43348 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfH0Ppx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:45:53 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6B849191904
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2019 17:45:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D92BDA7B6
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2019 17:45:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 53406B8001; Tue, 27 Aug 2019 17:45:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5EFBFDA72F;
        Tue, 27 Aug 2019 17:45:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 27 Aug 2019 17:45:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 34BA84265A5A;
        Tue, 27 Aug 2019 17:45:48 +0200 (CEST)
Date:   Tue, 27 Aug 2019 17:45:49 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: make sysctls per-namespace again
Message-ID: <20190827154549.unqmfovnxn5zvwn3@salvia>
References: <20190827135754.7d460ef8@pixies>
 <20190827112452.31479-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827112452.31479-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 27, 2019 at 01:24:52PM +0200, Florian Westphal wrote:
> When I merged the extension sysctl tables with the main one I forgot to
> reset them on netns creation.  They currently read/write init_net settings.

Applied, thanks Florian.
