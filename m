Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA96EB0F1
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 14:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJaNOX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 09:14:23 -0400
Received: from correo.us.es ([193.147.175.20]:50806 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfJaNOX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:14:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 17AA1FC5F4
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 14:14:19 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 09A6B21FF7
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 14:14:19 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F3640DA7B6; Thu, 31 Oct 2019 14:14:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 24B0FB7FF6;
        Thu, 31 Oct 2019 14:14:17 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 31 Oct 2019 14:14:17 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E984A42EE38F;
        Thu, 31 Oct 2019 14:14:16 +0100 (CET)
Date:   Thu, 31 Oct 2019 14:14:18 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Jallot <ejallot@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] doc: fix missing family in plural forms list command.
Message-ID: <20191031131418.kmlbqwg52y6jmr3w@salvia>
References: <20191030171917.45942-1-ejallot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030171917.45942-1-ejallot@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Also applied, thanks.
