Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2057B523E0
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 09:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfFYHDo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Jun 2019 03:03:44 -0400
Received: from a3.inai.de ([88.198.85.195]:40284 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfFYHDn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:03:43 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id EE5C23BB696B; Tue, 25 Jun 2019 09:03:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DFB943BB696A
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 09:03:42 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:03:42 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
cc:     Netfilter Developer Mailing List <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH 1/3] daemons: review owner and permissions on PF_LOCAL
 sockets
Message-ID: <nycvar.YFH.7.76.1906250902020.414@n3.vanv.qr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To:     unlisted-recipients:; (no To-header on input)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

meh, bash's Ctrl-R can be really evil :-p
