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
  id 843
  arrival_time 17505.737124537747
  lifetime 1458.053744613721
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 3
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 15
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 3
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 28
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 43
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 27
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 4
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 20
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 30
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
]
