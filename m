Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06998E59AC
	for <lists+netfilter-devel@lfdr.de>; Sat, 26 Oct 2019 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfJZKs3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 26 Oct 2019 06:48:29 -0400
Received: from correo.us.es ([193.147.175.20]:35390 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfJZKs3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 26 Oct 2019 06:48:29 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 035704A2B90
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Oct 2019 12:48:25 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EAFB74C3B4
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Oct 2019 12:48:24 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DEB22DA4D0; Sat, 26 Oct 2019 12:48:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B3A06DA7B6;
        Sat, 26 Oct 2019 12:48:22 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 26 Oct 2019 12:48:22 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8E61042EE38E;
        Sat, 26 Oct 2019 12:48:22 +0200 (CEST)
Date:   Sat, 26 Oct 2019 12:48:24 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     lvs-devel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Wensong Zhang <wensong@linux-vs.org>,
        Julian Anastasov <ja@ssi.bg>
Subject: Re: [GIT PULL] IPVS fixes for v5.4
Message-ID: <20191026104824.kareh25qmgfp4tuk@salvia>
References: <20191025111205.30555-1-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025111205.30555-1-horms@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 25, 2019 at 01:12:03PM +0200, Simon Horman wrote:
> Hi Pablo,
> 
> please consider these IPVS fixes for v5.4.
> 
> * Eric Dumazet resolves a race condition in switching the defense level
> 
> * Davide Caratti resolves a race condition in module removal
> 
> This pull request is based on nf.
> 
> 
> The following changes since commit 085461c8976e6cb4d5b608a7b7062f394c51a253:
> 
>   netfilter: nf_tables_offload: restore basechain deletion (2019-10-23 13:14:50 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git tags/ipvs-fixes-for-v5.4

Pulled, thanks Simon.
