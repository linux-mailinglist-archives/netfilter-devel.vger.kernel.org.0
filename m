Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B0345A3CA
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Nov 2021 14:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhKWNe2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Nov 2021 08:34:28 -0500
Received: from mail.netfilter.org ([217.70.188.207]:60430 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhKWNe2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:34:28 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 28F9D64704;
        Tue, 23 Nov 2021 14:29:08 +0100 (CET)
Date:   Tue, 23 Nov 2021 14:31:15 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCHv2 ulogd 1/2] NFLOG: add NFULNL_CFG_F_CONNTRACK flag
Message-ID: <YZztI3THtslzlaBx@salvia>
References: <YX1Bs7C5KIBvw6QC@azazel.net>
 <20211118110723.18855-1-chamas@h4.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118110723.18855-1-chamas@h4.dion.ne.jp>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 18, 2021 at 08:07:24PM +0900, Ken-ichirou MATSUZAWA wrote:
> acquiring conntrack information by specifying "attack_conntrack=1"

Applied, thanks
