Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F253552EEB
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jun 2022 11:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349395AbiFUJlO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jun 2022 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349550AbiFUJko (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:40:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2720127CDC
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jun 2022 02:40:30 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i7so5835700ybe.11
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jun 2022 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=B1uCY/ZGxNv+SuvqzWI7knAzBdNvauy3nycV+ph3RUTsvc0bIgej//rBgD1IbACYxY
         lotdEVzyaNtdyVr9ZeDp1niOo7yWEas4CEV2rY79ha1BAmRV0SJsI0qYuWVETvQd814U
         IfaxegJeOLNpcCtScCHv1MyD1aVb2XNeky1ErJbpgKCjDLU3YsdgKBLHmT3Y0/J19L9b
         m8rTR6N22ab0ixAnPqqzGqoCuZOXu6a5y2yQURUBJDXOTpTpi+tACyJCOVO2zP3qjTHg
         /yKEOCgygfbhX/it3nTJSDfK5FzkQJn0DFcaL9qjtnGeiS7i3VfV1apluDHIhCyiGayz
         po2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=NmNXIUKchK5N++nRz7g4JV/qiGoNNwS5M+BtdpEJM9GjdewopKmxZKPmYF+/Gw6EHk
         2GVjSHX4mm6K7qwTP2h61BXeUK/xKLxNyqlQZiufWivftTh8j1lMYuZPpfD8ElOUUINS
         23MSJg4lC2rm+STZatPT+48OoOHhwOPFyqG/EIcWVGxdZoIrijirDqjDrgQ06HUY+MuM
         I300ee+2OwVYKnG/9yiv/gXkHE8KtMb7RKQPjVz67q9YIsKsX7b8f/qM5gO6kJC4ApcJ
         QvaJmcXIP2QHcEOEq1BWFobckQ3KGJ5pSfr/BpmWcmzzI4PYo5nysAqupl99eN5D3rWc
         lO/w==
X-Gm-Message-State: AJIora99n+BmPTQXhotprH2rzuqMFvB5G/PFglz5d+RUy+8L88J3uuWX
        f/wSrDpE9xEZXkIKqDX3THptLnBIE1bYHwVrKH8=
X-Google-Smtp-Source: AGRyM1vSG2x5HwdezAKpMjHbtzSz/0s+tkpOBdmPJ9GeMAc1/LDkVjTgZNgrzSoFFu/of0F2Wkd9f0ksztrfYtGwCsw=
X-Received: by 2002:a25:b08c:0:b0:664:6f87:87a with SMTP id
 f12-20020a25b08c000000b006646f87087amr29569039ybj.181.1655804429168; Tue, 21
 Jun 2022 02:40:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:e10a:b0:2d9:e631:94d0 with HTTP; Tue, 21 Jun 2022
 02:40:28 -0700 (PDT)
Reply-To: dimitryedik@gmail.com
From:   Dimitry Edik <lsbthdwrds@gmail.com>
Date:   Tue, 21 Jun 2022 02:40:28 -0700
Message-ID: <CAGrL05buidt0f_Qx_VLU5-ZtAbz7vtzWPfVEnvxRmi33r-ALaA@mail.gmail.com>
Subject: Dear Partner,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lsbthdwrds[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello Dear,

My Name is Dimitry Edik from Russia A special assistance to my Russia
boss who deals in oil import and export He was killed by the Ukraine
soldiers at the border side. He supplied
oil to the Philippines company and he was paid over 90 per cent of the
transaction and the remaining $18.6 Million dollars have been paid into a
Taiwan bank in the Philippines..i want a partner that will assist me
with the claims. Is a (DEAL ) 40% for you and 60% for me
I have all information for the claims.
Kindly read and reply to me back is 100 per cent risk-free

Yours Sincerely
Dimitry Edik
