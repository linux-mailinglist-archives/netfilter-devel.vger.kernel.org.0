Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247FD109053
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Nov 2019 15:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfKYOrZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Nov 2019 09:47:25 -0500
Received: from correo.us.es ([193.147.175.20]:53762 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfKYOrY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:47:24 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F1B4B39627F
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2019 15:47:20 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F3EB9D2B1F
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2019 15:47:20 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E90DADA3A9; Mon, 25 Nov 2019 15:47:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1CD75A7EC5;
        Mon, 25 Nov 2019 15:47:19 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 25 Nov 2019 15:47:19 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C67834251481;
        Mon, 25 Nov 2019 15:47:18 +0100 (CET)
Date:   Mon, 25 Nov 2019 15:47:20 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables v2 2/2] files: add example secmark config
Message-ID: <20191125144720.tkvou7g4tmhzziux@salvia>
References: <20191123162240.14571-1-cgzones@googlemail.com>
 <20191123162240.14571-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123162240.14571-2-cgzones@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Applied, thanks.
