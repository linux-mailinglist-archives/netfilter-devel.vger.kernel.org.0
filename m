Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740475D3B6
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jul 2019 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGBP6U (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Jul 2019 11:58:20 -0400
Received: from mail.us.es ([193.147.175.20]:47818 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfGBP6U (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:58:20 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 90FB6B60CA
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Jul 2019 17:58:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 80B9AA6AC
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Jul 2019 17:58:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7626ADA708; Tue,  2 Jul 2019 17:58:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 400D7DA708;
        Tue,  2 Jul 2019 17:58:15 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 02 Jul 2019 17:58:15 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1A35A4265A32;
        Tue,  2 Jul 2019 17:58:15 +0200 (CEST)
Date:   Tue, 2 Jul 2019 17:58:14 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>,
        Vadim Fedorenko <vfedorenko@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        netfilter-devel@vger.kernel.org, lvs-devel@vger.kernel.org
Subject: Re: [PATCH v3] ipvs: allow tunneling with gre encapsulation
Message-ID: <20190702155814.fekk4sooblds7kzg@salvia>
References: <1561999774-8125-1-git-send-email-vfedorenko@yandex-team.ru>
 <alpine.LFD.2.21.1907012200110.3870@ja.home.ssi.bg>
 <20190702071656.c2uratq2ehgklo4b@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702071656.c2uratq2ehgklo4b@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:16:59AM +0200, Simon Horman wrote:
> On Mon, Jul 01, 2019 at 10:03:13PM +0300, Julian Anastasov wrote:
> > 
> > 	Hello,
> > 
> > 	Added CC to lvs-devel@vger.kernel.org
> > 
> > On Mon, 1 Jul 2019, Vadim Fedorenko wrote:
> > 
> > > windows real servers can handle gre tunnels, this patch allows
> > > gre encapsulation with the tunneling method, thereby letting ipvs
> > > be load balancer for windows-based services
> > > 
> > > Signed-off-by: Vadim Fedorenko <vfedorenko@yandex-team.ru>
> > 
> > 	Looks good to me, thanks!
> > 
> > Acked-by: Julian Anastasov <ja@ssi.bg>
> 
> Likewise,
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Pablo, please consider including this in nf-next.

Applied, thanks Simon.
