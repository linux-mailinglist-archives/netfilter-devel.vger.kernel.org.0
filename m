Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6AF9E648
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Aug 2019 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfH0LBD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Aug 2019 07:01:03 -0400
Received: from correo.us.es ([193.147.175.20]:52234 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfH0LBD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:01:03 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9BF87154E91
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2019 13:00:58 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8DEE6DA840
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2019 13:00:58 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 83898DA7B6; Tue, 27 Aug 2019 13:00:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8C883B7FF2;
        Tue, 27 Aug 2019 13:00:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 27 Aug 2019 13:00:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6028742EE396;
        Tue, 27 Aug 2019 13:00:56 +0200 (CEST)
Date:   Tue, 27 Aug 2019 13:00:57 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Jarosch <thomas.jarosch@intra2net.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_conntrack_ftp: Fix debug output
Message-ID: <20190827110057.fslgk46pwb7b2qh6@salvia>
References: <20190821141428.cjb535xrhpgry5zd@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821141428.cjb535xrhpgry5zd@intra2net.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:14:28PM +0200, Thomas Jarosch wrote:
> The find_pattern() debug output was printing the 'skip' character.
> This can be a NULL-byte and messes up further pr_debug() output.

Applied, thanks.
