Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F45398D5
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 May 2022 23:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiEaVeI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 31 May 2022 17:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbiEaVeH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 31 May 2022 17:34:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1318241F88
        for <netfilter-devel@vger.kernel.org>; Tue, 31 May 2022 14:34:05 -0700 (PDT)
Date:   Tue, 31 May 2022 23:34:02 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@chinatelecom.cn
Cc:     sven.auhagen@voleatech.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 1/2] netfilter: flowtable: fix nft_flow_route
 miss FLOWI_FLAG_ANYSRC flag
Message-ID: <YpaJyhN0MtfwtK8f@salvia>
References: <1653528346-5266-1-git-send-email-wenxu@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1653528346-5266-1-git-send-email-wenxu@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Applied to nf, thanks
