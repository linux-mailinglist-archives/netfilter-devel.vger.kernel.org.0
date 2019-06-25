Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36ED52600
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfFYIFs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Jun 2019 04:05:48 -0400
Received: from mail.us.es ([193.147.175.20]:39542 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfFYIFs (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:05:48 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2E7E4C3283
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 10:05:46 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19E3911510D
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 10:05:46 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0D7D5115107; Tue, 25 Jun 2019 10:05:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DFF92DA4D1;
        Tue, 25 Jun 2019 10:05:43 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Jun 2019 10:05:43 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B92CB4265A2F;
        Tue, 25 Jun 2019 10:05:43 +0200 (CEST)
Date:   Tue, 25 Jun 2019 10:05:43 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/3] build: unbreak non-functionality of --disable-python
Message-ID: <20190625080543.c7pvjmo34wm6pzyz@salvia>
References: <20190625065835.31188-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625065835.31188-1-jengelh@inai.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Applied, thanks.
