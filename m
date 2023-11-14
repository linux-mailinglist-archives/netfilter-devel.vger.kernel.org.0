Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0D57EBA20
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 00:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjKNXMI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Nov 2023 18:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjKNXMH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:12:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD4DD
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Nov 2023 15:12:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc131e52f1so2469695ad.0
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Nov 2023 15:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700003523; x=1700608323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:date:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mc2640dUUBJ9D7sviP8uQX4OO0PAk/9bQr/JIaaysdQ=;
        b=dM2GH4etDZcuaSfils8dSMoZuZ9vC6zSMe3GZyeanpbotFg5Ytp+cvcEqst3jWsSYn
         PKmxjbN8ZNMecskf4ZerkUBziJWVqUiv28mIsrg8FlpDRaaeTnO+iToF6yZBdCAYO/5k
         EtEZE3ZnJP/UvJmv3/w4wxBdIJQnDxH7CI975hCL0/tEFl7bce+Dt921jim2AFz+OlYW
         kBu5IMWAqaZY1QJAh9pEpwxsNDQmY7sGxaSclvBNQPYP2CNKEzJgCbu4MTaO4w30mvIE
         wEoKrGcAc3CbeCV6RwWy6A3yqGhJ+exzaWZvqPiyhTOJiuAonSNmTz0uk0aG1l0oiL0h
         W7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700003523; x=1700608323;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:date:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc2640dUUBJ9D7sviP8uQX4OO0PAk/9bQr/JIaaysdQ=;
        b=OvBk/Q+Yn3LQDtUJVyeAGcK/9O2Fk4dMwiyrmSVqlThfE+LWaDkFwyjw82hdQLuWCH
         WisKRKFD4MqODlh2L6azJiGR4AHuSQ3k4g4/exho3T7/YdWKyOa4+T21PDZoUCFCYkTu
         FySjQJnofHSKG2TBQLRuom1AYQsqxvb5qtBRBCp26b2U8lRP+csPNWAcpsyVKJPc0sYc
         Ki5NlSZqjgn3lKi8DqlLpcRiBk38a3LPP7WVCYMYdOemWcY72KwZepYSlOTZb1GRHrLH
         2wlUN7k3/w0Ic6jIV3qigy1iTur2v1NqcKVcQ6M/HrA7EP4YWlsq5G6BZTAiqeRaM/gS
         ROHw==
X-Gm-Message-State: AOJu0YzrPpB/rgewtwfhm0KeWXvZ7AngA2f8aBRddXTKpCTUSbpKpfA5
        sOXn2I6XYWsqfVzRhMJXb1Q=
X-Google-Smtp-Source: AGHT+IFUX7Hscy9qX26UUuRlAgmkREW4Ezck/V5WwUoakjpIr5GvJ7/sN//7s5cmL40s8+fXVv6JPQ==
X-Received: by 2002:a17:903:2805:b0:1cc:431f:55e3 with SMTP id kp5-20020a170903280500b001cc431f55e3mr3811554plb.28.1700003523322;
        Tue, 14 Nov 2023 15:12:03 -0800 (PST)
Received: from slk15.local.net (n58-108-90-185.meb1.vic.optusnet.com.au. [58.108.90.185])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902759200b001c0ce518e98sm6192033pll.224.2023.11.14.15.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 15:12:03 -0800 (PST)
Sender: Duncan Roe <duncan.roe2@gmail.com>
From:   Duncan Roe <duncan_roe@optusnet.com.au>
X-Google-Original-From: Duncan Roe <dunc@slk15.local.net>
Date:   Wed, 15 Nov 2023 10:11:59 +1100
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: *** Scrub that last message
Message-ID: <ZVP+v6O4MYlE+s4T@slk15.local.net>
Reply-To: duncan_roe@optusnet.com.au
Mail-Followup-To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
References: <20231112065922.3414-1-duncan_roe@optusnet.com.au>
 <ZVORGxjxolo3vnz1@calendula>
 <ZVP9D9KPgMkxLiB/@slk15.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVP9D9KPgMkxLiB/@slk15.local.net>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sorry, that was reply to another message
