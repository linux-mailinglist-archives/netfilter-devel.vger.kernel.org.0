Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75196DB564
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 20:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403977AbfJQSCz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 14:02:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39592 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403968AbfJQSCz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:02:55 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:5314:1b70:2a53:887e])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9686313FB6F7F;
        Thu, 17 Oct 2019 11:02:54 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:02:51 -0400 (EDT)
Message-Id: <20191017.140251.1580977190222713975.davem@davemloft.net>
To:     ecree@solarflare.com
Cc:     pablo@netfilter.org, jakub.kicinski@netronome.com,
        netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        jiri@resnulli.us, saeedm@mellanox.com, vishal@chelsio.com,
        vladbu@mellanox.com
Subject: Re: [PATCH net-next,v5 3/4] net: flow_offload: mangle action at
 byte level
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c4d14782-25dd-11a1-4147-2d8547ced3d1@solarflare.com>
References: <20191017161157.rr4lrolsjbnmk3ke@salvia>
        <20191017162237.h4e6bdoosd5b2ipj@salvia>
        <c4d14782-25dd-11a1-4147-2d8547ced3d1@solarflare.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 11:02:55 -0700 (PDT)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Edward Cree <ecree@solarflare.com>
Date: Thu, 17 Oct 2019 18:59:22 +0100

> Pedit is supposed to work even in the absence of protocol knowledge in
>  the kernel (e.g. in combination with cls_u32, you can filter and mangle
>  traffic in a completely new protocol), you're turning it into Yet
>  Another Ossified TCP/IP Monoculture.  This is not the direction the
>  networking offloads community is trying to move in.

Agreed, the proposed changes are taking the code and interfaces in
completely the wrong direction.

I agree with Jakub and Edward on all of these points.
