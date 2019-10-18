Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F61DBF85
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632740AbfJRIJU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Oct 2019 04:09:20 -0400
Received: from correo.us.es ([193.147.175.20]:35856 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504805AbfJRIJT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:09:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 344CC11EB3F
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 10:09:15 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0D48B52577
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 10:09:15 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2337DDA840; Fri, 18 Oct 2019 10:09:14 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DFF05B8009;
        Fri, 18 Oct 2019 10:09:11 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 18 Oct 2019 10:09:11 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BD37842EF4E1;
        Fri, 18 Oct 2019 10:09:11 +0200 (CEST)
Date:   Fri, 18 Oct 2019 10:09:13 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/8] xtables-restore: Treat struct
 nft_xt_restore_parse as const
Message-ID: <20191018080913.pcxvj3qraw3ttaw6@salvia>
References: <20191017224836.8261-1-phil@nwl.cc>
 <20191017224836.8261-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017224836.8261-2-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:48:29AM +0200, Phil Sutter wrote:
> This structure contains restore parser configuration, parser is not
> supposed to alter it.
> 
> Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
