Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32F012A883
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Dec 2019 17:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLYQVC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Dec 2019 11:21:02 -0500
Received: from rain.florz.de ([185.139.32.146]:33299 "EHLO rain.florz.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfLYQVC (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Dec 2019 11:21:02 -0500
X-Greylist: delayed 2656 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 11:21:02 EST
Received: from [2a07:12c0:1c00:43::121] (port=58340 helo=florz.florz.de)
        by rain.florz.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA256:256)
        (Exim 4.92)
        (envelope-from <florz@florz.de>)
        id 1ik8mZ-0003Pc-29
        for netfilter-devel@vger.kernel.org; Wed, 25 Dec 2019 16:41:07 +0100
Received: from florz by florz.florz.de with local (Exim 4.89)
        (envelope-from <florz@florz.de>)
        id 1ik8mY-0004FJ-Mt
        for netfilter-devel@vger.kernel.org; Wed, 25 Dec 2019 16:41:06 +0100
Date:   Wed, 25 Dec 2019 16:41:06 +0100
From:   Florian Zumbiehl <florz@florz.de>
To:     netfilter-devel@vger.kernel.org
Subject: [nftables] bug: rejects single-element intervals as supposedly empty
Message-ID: <20191225154106.x6mmx3m6hi7ksrao@florz.florz.de>
Mail-Followup-To: netfilter-devel@vger.kernel.org, florz@florz.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I stumbled upon this bug in the Debian buster backports version of nftables
(0.9.2-1~bpo10+1), the git commit log doesn't look like this has been fixed
since, so here it is:

| # nft add rule foo bar udp dport 1-1
| Error: Range has zero or negative size
| add rule foo bar udp dport 1-1
|                            ^^^

Regards, Florian
