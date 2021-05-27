Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD92393541
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 May 2021 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhE0SJX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 May 2021 14:09:23 -0400
Received: from mail.netfilter.org ([217.70.188.207]:38114 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhE0SJX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 May 2021 14:09:23 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id D5FEE6441E;
        Thu, 27 May 2021 20:06:46 +0200 (CEST)
Date:   Thu, 27 May 2021 20:07:45 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [ulogd2 PATCH] ulogd: printpkt: print pkt mark like kernel
Message-ID: <20210527180745.GA8767@salvia>
References: <20210524205913.18411-1-Cole.Dishington@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210524205913.18411-1-Cole.Dishington@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 25, 2021 at 08:59:13AM +1200, Cole Dishington wrote:
> Print the pkt mark in hex with a preceding '0x', like the kernel prints
> pkts logged by netfilter.

Applied, thanks.
