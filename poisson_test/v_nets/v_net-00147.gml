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
  id 147
  arrival_time 2614.7527954169095
  lifetime 2839.893774475089
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 18
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 4
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 26
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 37
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 25
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 32
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 26
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 8
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 47
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
]
