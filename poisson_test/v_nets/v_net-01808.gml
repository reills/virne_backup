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
  id 1808
  arrival_time 40163.326635264355
  lifetime 491.521543440952
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 4
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 14
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 45
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 9
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 32
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 26
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 4
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 33
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
]
