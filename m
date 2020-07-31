Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D0233C65
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 Jul 2020 02:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgGaAFo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Jul 2020 20:05:44 -0400
Received: from mx1.riseup.net ([198.252.153.129]:52424 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgGaAFo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:05:44 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BHnc74L5FzFd7D
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Jul 2020 17:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1596153943; bh=V/rmRBsbQKGBcofzogxHWC90KN5KGLpa9b505Gv/VTs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AFSrL4yvYDZzEjhGDa1XeLzK+/9bmvZdNp6SJGc2lJotFQd6GnKHRQnIvyENeMniM
         K6QJRSZwK7bvUgpE3UiqVFgY/bdUCAx8DL6K4HV1stwTPJBZagXN22MqPyDFdgidSS
         uiXVtA3XSJuBzImuRWo35Dm7IYWnQ0CwmT31JRQk=
X-Riseup-User-ID: 000CB4F7A256F7FC94D70C89AAB4770465A36CE8D59DDF87ABF525FA50357E1A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4BHnc70DHzzJn67
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Jul 2020 17:05:42 -0700 (PDT)
From:   "Jose M. Guisado Gomez" <guigom@riseup.net>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft v2 0/1] src: enable output with "nft --echo --json" and nftables syntax
Date:   Fri, 31 Jul 2020 02:00:20 +0200
Message-Id: <20200731000020.4230-1-guigom@riseup.net>
In-Reply-To: <20200730195337.3627-1-guigom@riseup.net>
References: <20200730195337.3627-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Version 2 of the patch passes tests/monitor by fixing newline formatting
issues that were introduced in v1. Newline output inside monitor.c
netlink callbacks functions are now checked per type, nftables or json. 

nftables always outputs a newline when finishing a netlink_event
callback inside monitor.c

json on the other hand only outputs a newline when we no echo output
flag has been provided (this is, nft running in monitor mode, not using
a mock monitor like the --echo and --json case)

Jose M. Guisado Gomez (1):
  src: enable output with "nft --echo --json" and nftables syntax

 include/nftables.h |  1 +
 src/json.c         | 13 ++++++++++---
 src/monitor.c      | 36 ++++++++++++++++++++++++++++--------
 src/parser_json.c  | 12 ++++++++----
 4 files changed, 47 insertions(+), 15 deletions(-)

-- 
2.28.0

