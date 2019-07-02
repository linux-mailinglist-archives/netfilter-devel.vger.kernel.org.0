Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C699B5D3BD
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jul 2019 17:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGBP7P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Jul 2019 11:59:15 -0400
Received: from mail.us.es ([193.147.175.20]:48240 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfGBP7P (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:59:15 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 12C07B60CA
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Jul 2019 17:59:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 04762D1929
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Jul 2019 17:59:13 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id ED64EDA801; Tue,  2 Jul 2019 17:59:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EFC2A10219C;
        Tue,  2 Jul 2019 17:59:10 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 02 Jul 2019 17:59:10 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id CE50A4265A31;
        Tue,  2 Jul 2019 17:59:10 +0200 (CEST)
Date:   Tue, 2 Jul 2019 17:59:10 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Vadim Fedorenko <vfedorenko@yandex-team.ru>
Subject: Re: [PATCH net-next] ipvs: strip gre tunnel headers from icmp errors
Message-ID: <20190702155910.kaijphjat5jiwqk5@salvia>
References: <20190701193415.5366-1-ja@ssi.bg>
 <20190702071903.4qrs2laft57smz7m@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702071903.4qrs2laft57smz7m@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:19:03AM +0200, Simon Horman wrote:
> On Mon, Jul 01, 2019 at 10:34:15PM +0300, Julian Anastasov wrote:
> > Recognize GRE tunnels in received ICMP errors and
> > properly strip the tunnel headers.
> > 
> > Signed-off-by: Julian Anastasov <ja@ssi.bg>
> 
> Thanks Julian,
> 
> this looks good to me.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Pablo, please consider including this in nf-next
> along with the dependency listed below.

Also applied, thanks Simon.
