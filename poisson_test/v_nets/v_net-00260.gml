graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 260
  arrival_time 4940.80775126877
  lifetime 877.608025789763
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 28
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 46
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 21
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 38
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 41
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 31
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 35
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 46
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 26
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 20
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 38
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 31
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 21
    gpu 11
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 50
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
  edge [
    source 11
    target 12
    bw 48
  ]
]
