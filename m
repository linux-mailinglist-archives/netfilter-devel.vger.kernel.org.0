Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1D910E16E
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Dec 2019 11:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfLAKk2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Dec 2019 05:40:28 -0500
Received: from a3.inai.de ([88.198.85.195]:44768 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfLAKk2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Dec 2019 05:40:28 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 05:40:27 EST
Received: by a3.inai.de (Postfix, from userid 25121)
        id 526FE58740D46; Sun,  1 Dec 2019 11:34:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 516C560D19E62;
        Sun,  1 Dec 2019 11:34:50 +0100 (CET)
Date:   Sun, 1 Dec 2019 11:34:50 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        "Thomas B . Clark" <kernel@clark.bz>
Subject: Re: [PATCH xtables-addons v2 0/3] xt_geoip: ipv6 fixes
In-Reply-To: <20191130175845.369240-1-jeremy@azazel.net>
Message-ID: <nycvar.YFH.7.76.1912011134260.10057@n3.vanv.qr>
References: <3971b408-51e6-d90e-f291-7a43e46e84c1@ferree-clark.org> <20191130175845.369240-1-jeremy@azazel.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Saturday 2019-11-30 18:58, Jeremy Sowden wrote:

>Thomas Clark reported that geoip matching didn't work for ipv6.  This
>series fixes that and a couple of other minor issues.

Applied 1, 3, with little fixes/additions to the messages.
