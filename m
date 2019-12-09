Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4D117829
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Dec 2019 22:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLIVPu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Dec 2019 16:15:50 -0500
Received: from correo.us.es ([193.147.175.20]:51534 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfLIVPu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:15:50 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 09788DA89B
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Dec 2019 22:15:47 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F14AEDA70E
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Dec 2019 22:15:46 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E6F92DA70D; Mon,  9 Dec 2019 22:15:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EC082DA70A;
        Mon,  9 Dec 2019 22:15:44 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 09 Dec 2019 22:15:44 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C96D44265A5A;
        Mon,  9 Dec 2019 22:15:44 +0100 (CET)
Date:   Mon, 9 Dec 2019 22:15:45 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 2/2] src: doc: Fully document
 available verdicts
Message-ID: <20191209211545.asjuglkxlrkravkh@salvia>
References: <20191209000506.14854-1-duncan_roe@optusnet.com.au>
 <20191209000506.14854-2-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209000506.14854-2-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 09, 2019 at 11:05:06AM +1100, Duncan Roe wrote:
> Updated:
> 
>  src/nlmsg.c - Document NF_DROP, NF_ACCEPT, NF_STOP, NF_REPEAT and
>                NF_QUEUE_NR(new_queue).
>              - Make line number of examples/nf-queue.c into a hyperlink.
>              - Add hint that "cb" in function names is short for "callback".

Also applied, thanks.
