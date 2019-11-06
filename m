Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F43F1548
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Nov 2019 12:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfKFLjh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Nov 2019 06:39:37 -0500
Received: from correo.us.es ([193.147.175.20]:33020 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbfKFLjh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:39:37 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B65FBC22E0
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Nov 2019 12:39:32 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A898DCE15C
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Nov 2019 12:39:32 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9CE9280132; Wed,  6 Nov 2019 12:39:32 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C2ACFDA4D0;
        Wed,  6 Nov 2019 12:39:30 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 06 Nov 2019 12:39:30 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 91CAA4251481;
        Wed,  6 Nov 2019 12:39:30 +0100 (CET)
Date:   Wed, 6 Nov 2019 12:39:32 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Jallot <ejallot@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: flowtable: add support for delete command by
 handle
Message-ID: <20191106113932.zmbhc23grr4bukes@salvia>
References: <20191104202359.26136-1-ejallot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104202359.26136-1-ejallot@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 04, 2019 at 09:23:59PM +0100, Eric Jallot wrote:
> Also, display handle when listing with '-a'.

Also applied.
