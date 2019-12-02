Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6910EE9E
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Dec 2019 18:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLBRkj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Dec 2019 12:40:39 -0500
Received: from correo.us.es ([193.147.175.20]:34704 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfLBRki (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:40:38 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5E359A1A33A
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Dec 2019 18:40:35 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4FA74DA70A
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Dec 2019 18:40:35 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 455DCDA707; Mon,  2 Dec 2019 18:40:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5012ADA70A;
        Mon,  2 Dec 2019 18:40:33 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 02 Dec 2019 18:40:33 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2E4614265A5A;
        Mon,  2 Dec 2019 18:40:33 +0100 (CET)
Date:   Mon, 2 Dec 2019 18:40:34 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v2] doc: fix inconsistency in set statement
 documentation.
Message-ID: <20191202174034.bhtkbrstqmpgd5qi@salvia>
References: <20191130113057.293776-1-jeremy@azazel.net>
 <20191130113057.293776-2-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130113057.293776-2-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 30, 2019 at 11:30:57AM +0000, Jeremy Sowden wrote:
> The description of the set statement asserts that the set must have been
> created with the "dynamic" flag.  However, this is not the case, and it
> is contradicted by the following example in which the "dynamic" flag
> does not appear.
> 
> In fact, one or both of the "dynamic" or the "timeout" flags need to be
> used, depending on what the set statement contains.  Amend the
> description to explain this more accurately.

Applied, thanks.
