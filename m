Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB51C1DBF
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2020 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgEATSv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 1 May 2020 15:18:51 -0400
Received: from correo.us.es ([193.147.175.20]:44014 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEATSv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 1 May 2020 15:18:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 635D311EB22
        for <netfilter-devel@vger.kernel.org>; Fri,  1 May 2020 21:18:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 54D62BAAA3
        for <netfilter-devel@vger.kernel.org>; Fri,  1 May 2020 21:18:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4A5682132B; Fri,  1 May 2020 21:18:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6EC02DA788;
        Fri,  1 May 2020 21:18:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 01 May 2020 21:18:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4709B4301DE1;
        Fri,  1 May 2020 21:18:48 +0200 (CEST)
Date:   Fri, 1 May 2020 21:18:47 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/3] utils: fix UBSAN warning in fls
Message-ID: <20200501191847.GB13722@salvia>
References: <20200501154819.2984-1-michael-dev@fami-braun.de>
 <20200501154819.2984-2-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501154819.2984-2-michael-dev@fami-braun.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 01, 2020 at 05:48:17PM +0200, Michael Braun wrote:
> ../include/utils.h:120:5: runtime error: left shift of 1103101952 by 1 places cannot be represented in type 'int'

Also applied, thanks.
