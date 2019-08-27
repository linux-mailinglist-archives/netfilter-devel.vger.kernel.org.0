Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695479E766
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Aug 2019 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfH0MLb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Aug 2019 08:11:31 -0400
Received: from correo.us.es ([193.147.175.20]:52818 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfH0MLb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:11:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E945B15C10B
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2019 14:11:27 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DB195DA4CA
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2019 14:11:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D0B5ADA840; Tue, 27 Aug 2019 14:11:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C4429DA72F;
        Tue, 27 Aug 2019 14:11:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 27 Aug 2019 14:11:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9B5804265A5A;
        Tue, 27 Aug 2019 14:11:25 +0200 (CEST)
Date:   Tue, 27 Aug 2019 14:11:26 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnftnl v2 1/2] expr: meta: Make
 NFT_META_TIME_{NS,DAY,HOUR} known
Message-ID: <20190827121126.h453sa2qhu7cluw5@salvia>
References: <20190817113248.9832-1-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817113248.9832-1-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Applied, thanks.
