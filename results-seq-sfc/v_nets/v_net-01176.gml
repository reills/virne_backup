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
  id 1176
  arrival_time 24372.139713780372
  lifetime 103.33977354415933
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 4
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 49
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 31
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 5
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 15
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 23
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 11
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 23
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 41
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 49
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
]
